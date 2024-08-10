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
}).strict();
