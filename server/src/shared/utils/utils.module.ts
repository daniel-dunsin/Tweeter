import { Module } from '@nestjs/common';
import { UtilService } from './utils.service';
import { CloudinaryProvider } from './cloudinary.provider';

@Module({
  providers: [UtilService],
  exports: [UtilService, CloudinaryProvider],
})
export class UtilsModule {}
