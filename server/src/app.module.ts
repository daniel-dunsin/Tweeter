import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { envSchema } from './shared/schemas/env.schema';
@Module({
  imports: [
    ConfigModule.forRoot({
      validationSchema: envSchema,
      envFilePath: '.env',
    }),
  ],
})
export class AppModule {}
