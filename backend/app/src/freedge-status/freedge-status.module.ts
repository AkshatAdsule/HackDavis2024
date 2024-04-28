import { Module } from '@nestjs/common';
import { FreedgeStatusService } from './freedge-status.service';
import { FreedgeStatusController } from './freedge-status.controller';
import { PrismaService } from 'nestjs-prisma';

@Module({
  controllers: [FreedgeStatusController],
  providers: [FreedgeStatusService],
  imports: [],
})
export class FreedgeStatusModule {}
