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
    return this.prismaService.user.findMany();
  }

  async getUserById(id: string) {
    return this.prismaService.user.findUnique({
      where: { id },
    });
  }

  async createUser(data: { email: string; name: string }) {
    return this.prismaService.user.create({
      data: {
        email: data.email,
        name: data.name,
      },
    });
  }

  async updateUser(id: string, data: { email: string; name: string }) {
    return this.prismaService.user.update({
      where: { id },
      data: {
        email: data.email,
        name: data.name,
      },
    });
  }

  async deleteUser(id: string) {
    return this.prismaService.user.delete({
      where: { id },
    });
  }

  async getItemsByUserId(userId: string) {
    return this.itemsService.getItemsByUserId(userId);
  }
}
