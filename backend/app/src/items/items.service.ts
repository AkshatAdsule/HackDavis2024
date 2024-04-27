import { Injectable } from '@nestjs/common';
import { PrismaService } from 'nestjs-prisma';
import { StorageService } from 'src/storage/storage.service';

@Injectable()
export class ItemsService {
  public static readonly PAGE_SIZE: number = 15;

  constructor(
    private prismaSerice: PrismaService,
    private storageService: StorageService,
  ) {}

  async getItems() {
    return this.prismaSerice.item.findMany({});
  }

  async getItemById(id: number) {
    return this.prismaSerice.item.findUnique({
      where: { id },
    });
  }

  async createItem(data: { name: string; ownerId: string }) {
    return this.prismaSerice.item.create({
      data,
    });
  }

  async getItemsByUserId(userId: string) {
    return this.prismaSerice.item.findMany({
      where: { ownerId: userId },
    });
  }
}
