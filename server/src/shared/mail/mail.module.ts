import { Module } from '@nestjs/common';
import { MailerModule } from '@nestjs-modules/mailer';
import { EjsAdapter } from '@nestjs-modules/mailer/dist/adapters/ejs.adapter';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { MailService } from './mail.service';

@Module({
  imports: [
    MailerModule.forRootAsync({
      inject: [ConfigService],
      imports: [ConfigModule],
      useFactory(configService: ConfigService) {
        const username = configService.get<string>('MAILER_USERNAME');
        const password = configService.get<string>('MAILER_PASS');

        return {
          transport: {
            service: 'gmail',
            auth: {
              user: username,
              pass: password,
            },
          },
          defaults: {
            from: '"No Reply" <noreply@tweeter.com>',
          },
          template: {
            dir: __dirname + '../../../../src/shared/mail/templates',
            adapter: new EjsAdapter(),
            options: { strict: false },
          },
        };
      },
    }),
  ],
  providers: [MailService],
  exports: [MailService],
})
export class MailModule {}
