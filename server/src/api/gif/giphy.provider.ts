import { GiphyFetch } from '@giphy/js-fetch-api';
import { Provider } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

export const GIPHY_PROVIDER = 'GIPHY_PROVIDER';

export const GiphyProvider: Provider = {
  provide: GIPHY_PROVIDER,
  inject: [ConfigService],
  useFactory(configService: ConfigService) {
    const GIPHY_API_KEY = configService.get<string>('GIPHY_API_KEY');

    return new GiphyFetch(GIPHY_API_KEY);
  },
};
