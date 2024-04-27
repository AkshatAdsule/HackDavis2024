import { Module } from '@nestjs/common';
import { UsersService } from './users.service';
import { UsersController } from './users.controller';
import { ItemsService } from 'src/items/items.service';
import { ItemsModule } from 'src/items/items.module';

@Module({
  controllers: [UsersController],
  providers: [UsersService],
  imports: [ItemsModule],
})
export class UsersModule {}
