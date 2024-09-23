import { Injectable } from '@nestjs/common';
import { UtilService } from 'src/shared/utils/utils.service';

@Injectable()
export class MediaService {
  constructor(private readonly utilService: UtilService) {}

  async uploadBulkMedia(file: Express.Multer.File) {
    return await this.utilService.uploadFileAsset(file);
  }
}
