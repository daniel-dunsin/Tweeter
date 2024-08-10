import { Injectable } from '@nestjs/common';
import { genSalt, hash, compare } from 'bcryptjs';
import { generate } from 'otp-generator';

@Injectable()
export class UtilService {
  async hashPassword(password: string) {
    const saltFactor = await genSalt(12);
    const hashedPassword = await hash(password, saltFactor);
    return hashedPassword;
  }

  async comparePassword(password: string, hash: string) {
    return await compare(password, hash);
  }

  getOtp() {
    return generate(6, {
      specialChars: false,
      lowerCaseAlphabets: false,
    });
  }
}
