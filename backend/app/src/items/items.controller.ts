import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { ItemsService } from './items.service';

@Controller('items')
export class ItemsController {
  constructor(private readonly itemsService: ItemsService) {}

  @Get()
  async getItems() {
    return this.itemsService.getItems();
  }

  @Get(':id')
  async getItemById(@Param('id') id: number) {
    return this.itemsService.getItemById(id);
  }

  @Post()
  async createItem(@Body() data: { name: string; ownerId: string }) {
    return this.itemsService.createItem(data);
  }
}
