import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { PrismaModule } from 'nestjs-prisma';
import { ConfigModule } from '@nestjs/config';
import { UsersModule } from './users/users.module';
import { ItemsModule } from './items/items.module';
import { FreedgeStatusModule } from './freedge-status/freedge-status.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      ignoreEnvFile: true,
      ignoreEnvVars: false,
      cache: true,
    }),
    PrismaModule.forRoot({ isGlobal: true }),
    UsersModule,
    ItemsModule,
    FreedgeStatusModule,
  ],
  controllers: [AppController],
  providers: [],
})
export class AppModule {}
