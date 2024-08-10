import { User } from '@prisma/client';

export class SignJwtDto {
  user: User;
}
