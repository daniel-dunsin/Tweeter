import { Controller } from '@nestjs/common';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';

@Controller('category')
@ApiTags('category')
@ApiBearerAuth()
export class CategoryController {}
