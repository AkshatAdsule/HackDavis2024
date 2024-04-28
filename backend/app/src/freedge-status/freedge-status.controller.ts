import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Put,
  Res,
} from '@nestjs/common';
import { FreedgeStatusService } from './freedge-status.service';
import { Response } from 'express';

@Controller('freedge')
export class FreedgeStatusController {
  constructor(private readonly freedgeStatusService: FreedgeStatusService) {}

  @Get()
  async getAllFreedgeStatus() {
    return this.freedgeStatusService.getAllFreedgeStatus();
  }

  @Get(':id')
  async getFreedgeStatus(@Param('id') id: string) {
    return this.freedgeStatusService.getFreedgeDetails(parseInt(id));
  }

  @Put(':id')
  async updateFreedgeStatus(
    @Param('id') id: string,
    @Body('image') image: string,
  ) {
    return this.freedgeStatusService.saveImageToDisk(parseInt(id), image);
  }

  @Get(':id/image')
  async getFreedgeImage(@Param('id') id: string, @Res() res: Response) {
    const path = process.cwd() + `/uploads/${id}.png`;
    res.sendFile(path);
  }

  @Post(':id')
  async addItemsToFreedge(
    @Param('id') id: string,
    @Body()
    data: {
      name: string;
      image: string | null;
      score: number;
      quantity: number;
      ownerId: string;
    },
  ) {
    return this.freedgeStatusService.addItemToFreedge(parseInt(id), data);
  }
}
