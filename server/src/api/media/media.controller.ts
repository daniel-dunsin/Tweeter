import { Controller, UploadedFiles, UseInterceptors } from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { ApiConsumes } from '@nestjs/swagger';
import { MULTER_DISK_STORAGE } from './config';
import { MediaService } from './media.service';

@Controller()
export class MediaController {
  constructor(private readonly mediaService: MediaService) {}

  @ApiConsumes('multipart/form-data')
  @UseInterceptors(FileInterceptor('file', { storage: MULTER_DISK_STORAGE }))
  async uploadFiles(@UploadedFiles() file: Express.Multer.File) {
    const data = await this.mediaService.uploadBulkMedia(file);

    return data;
  }
}
