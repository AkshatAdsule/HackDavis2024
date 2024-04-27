import { Module } from '@nestjs/common';
import { ItemsService } from './items.service';
import { ItemsController } from './items.controller';
import { StorageService } from 'src/storage/storage.service';

@Module({
  controllers: [ItemsController],
  providers: [ItemsService, StorageService],
  exports: [ItemsService],
})
export class ItemsModule {}
