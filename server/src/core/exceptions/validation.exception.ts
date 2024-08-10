import { BadRequestException, ValidationError } from '@nestjs/common';

export class ValidationExceptions extends BadRequestException {
  constructor(errors: ValidationError[]) {
    super({
      error: 'Validation Exception',
      message: errors
        .map((error) =>
          error.constraints ? Object.values(error.constraints) : [],
        )
        .flat()[0],
    });
  }
}
