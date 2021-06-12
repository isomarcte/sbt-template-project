import scala.collection.immutable.SortedSet

// Constants //

lazy val scala211V: String = "2.11.12"
lazy val scala212V: String = "2.12.14"
lazy val scala213V: String = "2.13.6"
lazy val scala30V: String  = "3.0.0"
lazy val scalaVersions: SortedSet[String] = SortedSet(scala211V, scala212V, scala213V, scala30V)

// Project
lazy val projectName: String = "<PROJECT_NAME>"
lazy val projectOrg: String = "<PROJECT_ORG>"

// SBT Command Aliases //
// Usually run before making a PR
addCommandAlias(
  "full_build",
  s";+clean;githubWorkflowGenerate;+test;+test:doc;docs/mdoc;+versionSchemeEnforcerCheck;++${scala213V};scalafmtAll;scalafmtSbt;scalafixAll"
)

// ThisBuild //

// POM
ThisBuild / organization := isomarcteOrg
ThisBuild / versionScheme := Some("pvp")

// Scala
ThisBuild / scalaVersion := scala213V
ThisBuild / crossScalaVersions := scalaVersions.toSeq

// Scalafix
ThisBuild / scalafixScalaBinaryVersion := scalaBinaryVersion.value
ThisBuild / semanticdbEnabled := true
ThisBuild / semanticdbVersion := scalafixSemanticdb.revision

// Projects //
def projectModule(name: String): Project = {
  Project(name, file(s"modules/$name"))
}

// Root

lazy val root: Project = (project in file(".")).settings(
  name := s"${projectName}-root"
)
