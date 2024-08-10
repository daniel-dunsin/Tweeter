-- DropIndex
DROP INDEX "users_userName_key";

-- AlterTable
ALTER TABLE "auths" ADD COLUMN     "userName" TEXT;
