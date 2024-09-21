import { IsString } from 'src/core/decorators/validators.decorator';

export class DefaultQueryDto {
  @IsString(true)
  page?: string;

  @IsString(true)
  limit?: string;

  @IsString(true)
  search?: string;
}
