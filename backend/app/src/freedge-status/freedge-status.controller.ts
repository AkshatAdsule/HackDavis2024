import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Put,
} from '@nestjs/common';
import { FreedgeStatusService } from './freedge-status.service';

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
    return this.freedgeStatusService.updateFreedgeStatus(parseInt(id), image);
  }
}
