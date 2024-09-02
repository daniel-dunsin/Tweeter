import { Module } from '@nestjs/common';
import { UtilService } from './utils.service';
import { CloudinaryProvider } from './cloudinary.provider';
import { ConfigModule } from '@nestjs/config';
import { PrismaModule } from '../prisma/prisma.module';

@Module({
  imports: [ConfigModule, PrismaModule],
  providers: [UtilService, CloudinaryProvider],
  exports: [UtilService],
})
export class UtilsModule {}
