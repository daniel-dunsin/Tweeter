import { Module } from '@nestjs/common';
import { GifController } from './gif.controller';
import { GifService } from './gif.service';
import { GiphyProvider } from './giphy.provider';
import { ConfigModule } from '@nestjs/config';
import { SharedModule } from 'src/shared/shared.module';

@Module({
  imports: [ConfigModule, SharedModule],
  controllers: [GifController],
  providers: [GifService, GiphyProvider],
  exports: [GifService],
})
export class GifModule {}
