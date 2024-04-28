import { Injectable } from '@nestjs/common';
import { PrismaService } from 'nestjs-prisma';
import { ItemsService } from 'src/items/items.service';

@Injectable()
export class UsersService {
  constructor(
    private prismaService: PrismaService,
    private itemsService: ItemsService,
  ) {}

  async getUsers() {
    return this.prismaService.user.findMany({ orderBy: { points: 'desc' } });
  }

  async getUserById(id: string) {
    return this.prismaService.user.findUnique({
      where: { uid: id },
    });
  }

  async createUser(data: {
    uid: string;
    email: string;
    name: string;
    profilePhoto: string;
  }) {
    return this.prismaService.user.create({
      data,
    });
  }

  async updateUser(id: string, data: { email: string; name: string }) {
    return this.prismaService.user.update({
      where: { uid: id },
      data: {
        email: data.email,
        name: data.name,
      },
    });
  }

  async deleteUser(id: string) {
    return this.prismaService.user.delete({
      where: { uid: id },
    });
  }

  async getItemsByUserId(userId: string) {
    return this.itemsService.getItemsByUserId(userId);
  }

  async getLeaderboard() {
    return this.prismaService.user.findMany();
  }
}
