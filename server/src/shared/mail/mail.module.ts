import { Module } from '@nestjs/common';
import { MailerModule } from '@nestjs-modules/mailer';
import { EjsAdapter } from '@nestjs-modules/mailer/dist/adapters/ejs.adapter';
import { ConfigModule, ConfigService } from '@nestjs/config';

@Module({
  imports: [
    MailerModule.forRootAsync({
      inject: [ConfigService],
      imports: [ConfigModule],
      useFactory(configService: ConfigService) {
        const username = configService.get<string>('MAILER_USERNAME');
        const password = configService.get<string>('MAILER_PASSWORD');

        return {
          transport: {
            service: 'gmail',
            auth: {
              user: username,
              password: password,
            },
          },
          defaults: {
            from: '"No Reply" <noreply@tweeter.com>',
          },
          template: {
            dir: __dirname + '/templates',
            adapter: new EjsAdapter(),
            options: { strict: true },
          },
        };
      },
    }),
  ],
})
export class MailModule {}
