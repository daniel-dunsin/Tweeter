import { MailerService } from '@nestjs-modules/mailer';
import { Injectable } from '@nestjs/common';
import { ISendMailOptions } from './interfaces/mail.interface';

@Injectable()
export class MailService {
  constructor(private readonly mailerService: MailerService) {}

  async sendMail(options: ISendMailOptions) {
    return await this.mailerService
      .sendMail({
        from: 'noreply@tweeter.com',
        to: options.to,
        subject: options.subject,
        template: options.template,
        context: { ...options.context },
      })
      .then(() => {})
      .catch((error) => console.error(`[mailer]: ${error.message ?? error}`));
  }
}
