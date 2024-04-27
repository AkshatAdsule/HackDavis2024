import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { ValidationPipe } from '@nestjs/common';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // add validation pipe
  app.useGlobalPipes(new ValidationPipe());

  // setup swagger
  const options = new DocumentBuilder()
    .setTitle('WildHorse ANI App API')
    .setVersion('1.0')
    .build();

  const document = SwaggerModule.createDocument(app, options);
  SwaggerModule.setup('api', app, document);

  app.enableShutdownHooks();
  app.enableCors();
  await app.listen(3000);
}
bootstrap();
