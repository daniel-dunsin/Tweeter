export interface ISendMailOptions {
  to: string;
  subject: string;
  template: string;
  context: object;
}

export interface ISendBulkMailOptions {
  to: {
    email: string;
    context: object;
  }[];
  template: string;
  subject: string;
}
