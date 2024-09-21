import { Controller, Get, Query } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { GetGifsQuery } from './dtos';
import { GifService } from './gif.service';

@Controller('gifs')
@ApiTags('gifs')
export class GifController {
  constructor(private readonly gifService: GifService) {}

  @Get()
  async getGifs(@Query() query: GetGifsQuery) {
    return await this.gifService.getGifs(query);
  }
}
