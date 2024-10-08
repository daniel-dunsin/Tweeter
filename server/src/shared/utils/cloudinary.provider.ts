import { Provider } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { v2 } from 'cloudinary';

export const CLOUDINARY_PROVIDER = 'CLOUDINARY_PROVIDER';

export const CloudinaryProvider: Provider = {
  provide: CLOUDINARY_PROVIDER,
  inject: [ConfigService],
  useFactory(configService: ConfigService) {
    v2.config({
      api_key: configService.get<string>('CLOUDINARY_API_KEY'),
      api_secret: configService.get<string>('CLOUDINARY_API_SECRET'),
      cloud_name: configService.get<string>('CLOUDINARY_CLOUD_NAME'),
    });

    return v2;
  },
};
