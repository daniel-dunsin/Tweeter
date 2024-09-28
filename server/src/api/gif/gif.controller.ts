import { Controller, Get, Query } from '@nestjs/common';
import { ApiTags, ApiBearerAuth } from '@nestjs/swagger';
import { GetGifsQuery } from './dtos';
import { GifService } from './gif.service';
import { IsPublic } from 'src/core/decorators/auth.decorator';

@Controller('gifs')
@ApiTags('gifs')
@ApiBearerAuth()
export class GifController {
  constructor(private readonly gifService: GifService) {}

  @Get()
  @IsPublic()
  async getGifs(@Query() query: GetGifsQuery) {
    return await this.gifService.getGifs(query);
  }
}
