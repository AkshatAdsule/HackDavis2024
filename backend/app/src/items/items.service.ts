import { Injectable } from '@nestjs/common';
import { PrismaService } from 'nestjs-prisma';
import { StorageService } from 'src/storage/storage.service';

@Injectable()
export class ItemsService {
  public static readonly PAGE_SIZE: number = 15;

  constructor(
    private prismaService: PrismaService,
    private storageService: StorageService,
  ) {}

  async getItems() {
    return this.prismaService.item.findMany({
      include: { owner: true },
    });
  }

  async getItemById(id: number) {
    return this.prismaService.item.findUnique({
      where: { id },
    });
  }

  async createItem(data: { name: string; ownerId: string }) {
    return this.prismaService.item.create({
      data,
    });
  }

  async getItemsByUserId(userId: string) {
    return this.prismaService.item.findMany({
      where: { ownerId: userId },
    });
  }
}
