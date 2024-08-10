import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { envSchema } from './shared/schemas/env.schema';
import { SharedModule } from './shared/shared.module';
import { ApiModule } from './api/api.module';
@Module({
  imports: [
    ConfigModule.forRoot({
      validationSchema: envSchema,
      envFilePath: '.env',
    }),
    SharedModule,
    ApiModule,
  ],
})
export class AppModule {}
