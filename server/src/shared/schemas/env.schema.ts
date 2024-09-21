import * as Joi from 'joi';

export enum NodeEnv {
  Development = 'development',
  Production = 'production',
  Testing = 'testing',
}

export const envSchema = Joi.object({
  DATABASE_URL: Joi.string().required(),
  PORT: Joi.string().required(),
  NODE_ENV: Joi.string().required().allow(NodeEnv),
  JWT_SECRET: Joi.string().required(),
  MAILER_USERNAME: Joi.string().required(),
  MAILER_PASS: Joi.string().required(),
  REDIS_PORT: Joi.string().required(),
  REDIS_PASSWORD: Joi.string().required(),
  REDIS_HOST: Joi.string().required(),
  CLOUDINARY_API_KEY: Joi.string().required(),
  CLOUDINARY_API_SECRET: Joi.string().required(),
  CLOUDINARY_CLOUD_NAME: Joi.string().required(),
  GIPHY_API_KEY: Joi.string().required(),
}).strict();
