import { Injectable } from '@nestjs/common';
import { Freedge } from '@prisma/client';
import { PrismaService } from 'nestjs-prisma';
import { join } from 'path';

var fs = require('fs');

@Injectable()
export class FreedgeStatusService {
  constructor(private readonly prismaService: PrismaService) {}

  async getFreedgeDetails(id: number): Promise<Freedge> {
    return this.prismaService.freedge.findUnique({
      where: { id },
      include: { items: { include: { owner: true } } },
    });
  }

  async addItemToFreedge(
    freedgeId: number,
    item: {
      name: string;
      image: string | null;
      score: number;
      quantity: number;
      ownerId: string;
    },
  ): Promise<void> {
    // Add items to the freedge
    console.log(item);
    // const itemsData = items.map((item) => ({
    //   name: item.name,
    //   image: item.image,
    //   score: item.score,
    //   quantity: item.quantity,
    //   freedgeId,
    //   ownerId: 'clvir9yha0000qwd2xyx4qn6p',
    // }));

    const itemData = {
      ...item,
      freedgeId: freedgeId,
    };

    // update score for the user
    const user = await this.prismaService.user.findUnique({
      where: { uid: item.ownerId },
    });

    await this.prismaService.user.update({
      where: { uid: item.ownerId },
      data: {
        points: user.points + item.score,
      },
    });

    await this.prismaService.item.create({
      data: itemData,
    });
  }

  async createFreedgeStatus(data: Freedge): Promise<Freedge> {
    return this.prismaService.freedge.create({ data });
  }

  async saveImageToDisk(id: number, imageBytes: string): Promise<void> {
    // Save the file to disk and return the path
    const path = join(__dirname, `../../uploads/${id}.png`);
    await fs.writeFileSync(path, imageBytes, 'base64');
  }

  async getAllFreedgeStatus(): Promise<Freedge[]> {
    return this.prismaService.freedge.findMany();
  }
}
