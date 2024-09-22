-- CreateTable
CREATE TABLE "TweetMentions" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TweetMentions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "TweetLocation" (
    "id" TEXT NOT NULL,
    "tweetId" TEXT NOT NULL,
    "lng" DECIMAL(65,30) NOT NULL,
    "lat" DECIMAL(65,30) NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "TweetLocation_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "TweetLocation_tweetId_key" ON "TweetLocation"("tweetId");

-- AddForeignKey
ALTER TABLE "TweetMentions" ADD CONSTRAINT "TweetMentions_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "TweetLocation" ADD CONSTRAINT "TweetLocation_tweetId_fkey" FOREIGN KEY ("tweetId") REFERENCES "tweets"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
