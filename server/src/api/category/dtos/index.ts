import { IsString } from 'src/core/decorators/validators.decorator';

export class CreateCategoryDto {
  @IsString(false)
  name: string;

  @IsString(true)
  description?: string;
}

export class CreateSubCategoryDto {
  @IsString(false)
  name: string;

  @IsString(true)
  description?: string;

  @IsString(false)
  categoryId: string;
}
