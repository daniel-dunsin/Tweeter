import { diskStorage } from 'multer';
import { extname, join } from 'path';

export const MULTER_DISK_STORAGE = diskStorage({
  destination: join(__dirname, '../uploads'),
  filename(req, file, cb) {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
    const extension = extname(file.originalname);
    cb(null, `${uniqueSuffix}${extension}`);
  },
});

export const MAX_UPLOAD_COUNT = 4;
