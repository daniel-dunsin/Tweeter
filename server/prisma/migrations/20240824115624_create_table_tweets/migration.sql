-- CreateEnum
CREATE TYPE "TweetMediaType" AS ENUM ('image', 'video', 'audio');

-- CreateTable
CREATE TABLE "tweets" (
    "id" TEXT NOT NULL,
    "text" TEXT,
    "parentTweetId" TEXT,
    "quotedTweetId" TEXT,
    "tweeterId" TEXT NOT NULL,
    "likersIds" TEXT[],

    CONSTRAINT "tweets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TweetMedia" (
    "id" TEXT NOT NULL,
    "type" "TweetMediaType" NOT NULL,
    "url" TEXT NOT NULL,
    "publicId" TEXT NOT NULL,
    "tweetId" TEXT NOT NULL,

    CONSTRAINT "TweetMedia_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "hashtags" (
    "id" TEXT NOT NULL,
    "text" TEXT NOT NULL,

    CONSTRAINT "hashtags_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_UserRetweet" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_Likes" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_Bookmarks" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_HashTagToTweet" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_UserRetweet_AB_unique" ON "_UserRetweet"("A", "B");

-- CreateIndex
CREATE INDEX "_UserRetweet_B_index" ON "_UserRetweet"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_Likes_AB_unique" ON "_Likes"("A", "B");

-- CreateIndex
CREATE INDEX "_Likes_B_index" ON "_Likes"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_Bookmarks_AB_unique" ON "_Bookmarks"("A", "B");

-- CreateIndex
CREATE INDEX "_Bookmarks_B_index" ON "_Bookmarks"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_HashTagToTweet_AB_unique" ON "_HashTagToTweet"("A", "B");

-- CreateIndex
CREATE INDEX "_HashTagToTweet_B_index" ON "_HashTagToTweet"("B");

-- AddForeignKey
ALTER TABLE "tweets" ADD CONSTRAINT "tweets_parentTweetId_fkey" FOREIGN KEY ("parentTweetId") REFERENCES "tweets"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tweets" ADD CONSTRAINT "tweets_quotedTweetId_fkey" FOREIGN KEY ("quotedTweetId") REFERENCES "tweets"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tweets" ADD CONSTRAINT "tweets_tweeterId_fkey" FOREIGN KEY ("tweeterId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TweetMedia" ADD CONSTRAINT "TweetMedia_tweetId_fkey" FOREIGN KEY ("tweetId") REFERENCES "tweets"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UserRetweet" ADD CONSTRAINT "_UserRetweet_A_fkey" FOREIGN KEY ("A") REFERENCES "tweets"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UserRetweet" ADD CONSTRAINT "_UserRetweet_B_fkey" FOREIGN KEY ("B") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_Likes" ADD CONSTRAINT "_Likes_A_fkey" FOREIGN KEY ("A") REFERENCES "tweets"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_Likes" ADD CONSTRAINT "_Likes_B_fkey" FOREIGN KEY ("B") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_Bookmarks" ADD CONSTRAINT "_Bookmarks_A_fkey" FOREIGN KEY ("A") REFERENCES "tweets"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_Bookmarks" ADD CONSTRAINT "_Bookmarks_B_fkey" FOREIGN KEY ("B") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_HashTagToTweet" ADD CONSTRAINT "_HashTagToTweet_A_fkey" FOREIGN KEY ("A") REFERENCES "hashtags"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_HashTagToTweet" ADD CONSTRAINT "_HashTagToTweet_B_fkey" FOREIGN KEY ("B") REFERENCES "tweets"("id") ON DELETE CASCADE ON UPDATE CASCADE;
