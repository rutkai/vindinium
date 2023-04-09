lazy val vindinium = (project in file(".")).enablePlugins(PlayScala)

name := "vindinium"

version := "1.1"

scalaVersion := "2.12.17"

libraryDependencies ++= Seq(
  "org.reactivemongo" %% "reactivemongo" % "0.12.4",
  "org.reactivemongo" %% "play2-reactivemongo" % "0.12.4",
  "joda-time" % "joda-time" % "2.3")

resolvers ++= Seq(
  "sonatype snapshots" at "https://oss.sonatype.org/content/repositories/snapshots",
  "Typesafe Simple Repository" at "https://repo.typesafe.com/typesafe/simple/maven-releases/")

scalacOptions ++= Seq("-feature", "-language:_", "-unchecked", "-deprecation")

Compile / TwirlKeys.templateImports ++= Seq(
  "org.vindinium.server.{ Game, Board, Hero, JsonFormat }",
  "org.vindinium.server.system.Replay",
  "org.vindinium.server.user.User")

Compile / doc / sources := List()
