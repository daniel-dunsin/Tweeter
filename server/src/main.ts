import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe, VersioningType } from '@nestjs/common';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { ConfigService } from '@nestjs/config';
import { GlobalFilter } from './core/filters/global.filter';
import { NestExpressApplication } from '@nestjs/platform-express';
import { ValidationExceptions } from './core/exceptions/validation.exception';

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);
  app.setGlobalPrefix('/api');
  app.enableVersioning({ type: VersioningType.URI, prefix: 'v1' });
  app.enableCors();
  app.disable('x-powered-by');

  app.useGlobalPipes(
    new ValidationPipe({
      transform: true,
      exceptionFactory: (errors) => new ValidationExceptions(errors),
    }),
  );

  app.useGlobalFilters(new GlobalFilter());

  const swaggerBuild = new DocumentBuilder()
    .setVersion('1.0.0')
    .setTitle('Tweeter')
    .setContact(
      'Adejare Daniel',
      'https://github.com/daniel-dunsin',
      'adejaredaniel12@gmail.com',
    )
    .addBearerAuth()
    .build();

  const swaggerDocument = SwaggerModule.createDocument(app, swaggerBuild);
  SwaggerModule.setup('/api/v1/docs', app, swaggerDocument);

  const configService = app.get(ConfigService);
  const PORT = configService.get<string>('PORT');
  await app.listen(PORT);
}
bootstrap();
