import { Module } from '@nestjs/common';
import { UtilService } from './utils.service';
import { CloudinaryProvider } from './cloudinary.provider';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [ConfigModule],
  providers: [UtilService, CloudinaryProvider],
  exports: [UtilService],
})
export class UtilsModule {}
