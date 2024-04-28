import { Injectable } from '@nestjs/common';
import { Freedge } from '@prisma/client';
import { PrismaService } from 'nestjs-prisma';

@Injectable()
export class FreedgeStatusService {
  constructor(private readonly prismaService: PrismaService) {}

  async getFreedgeDetails(id: number): Promise<Freedge> {
    return this.prismaService.freedge.findUnique({
      where: { id },
      include: { items: true },
    });
  }

  async createFreedgeStatus(data: Freedge): Promise<Freedge> {
    return this.prismaService.freedge.create({ data });
  }

  async updateFreedgeStatus(id: number, image: string): Promise<Freedge> {
    return this.prismaService.freedge.update({
      where: { id },
      data: { image },
    });
  }

  async getAllFreedgeStatus(): Promise<Freedge[]> {
    return this.prismaService.freedge.findMany();
  }
}
