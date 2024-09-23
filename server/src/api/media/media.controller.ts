import {
  Controller,
  Post,
  UploadedFiles,
  UseInterceptors,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { ApiBearerAuth, ApiBody, ApiConsumes, ApiTags } from '@nestjs/swagger';
import { MULTER_DISK_STORAGE } from './config';
import { MediaService } from './media.service';

@Controller('media')
@ApiTags('media')
@ApiBearerAuth()
export class MediaController {
  constructor(private readonly mediaService: MediaService) {}

  @Post()
  @ApiConsumes('multipart/form-data')
  @UseInterceptors(FileInterceptor('file', { storage: MULTER_DISK_STORAGE }))
  @ApiBody({
    schema: {
      type: 'object',
      properties: {
        file: {
          type: 'binary',
        },
      },
    },
  })
  async uploadFiles(@UploadedFiles() file: Express.Multer.File) {
    const data = await this.mediaService.uploadBulkMedia(file);

    return data;
  }
}
