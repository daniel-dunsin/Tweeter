import { Controller } from '@nestjs/common';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';

@Controller('tweets')
@ApiBearerAuth()
@ApiTags('tweets')
export class TweetsController {}
