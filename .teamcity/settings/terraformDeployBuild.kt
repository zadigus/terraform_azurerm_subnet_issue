package settings

import jetbrains.buildServer.configs.kotlin.v2019_2.BuildType
import jetbrains.buildServer.configs.kotlin.v2019_2.buildSteps.script
import shared.azure.build_steps.publishAzureResourceData
import shared.common.Agent
import shared.common.Architecture
import shared.common.DockerImage
import shared.common.build_steps.publishJiraProjectId
import shared.infrastructure.build_steps.publishTerraformVariables
import shared.infrastructure.build_steps.terraformConfig
import shared.infrastructure.build_steps.terraformDeploy
import shared.templates.ArtifactoryDockerLogin
import shared.templates.EnvironmentSetup


class TerraformDeployBuild(
    dockerImage: DockerImage,
    agent: Agent = Agent(architecture = Architecture.AMD64),
    scriptPath: String,
    projectName: String,
    deploymentWorkingDirectory: String = "",
) : BuildType({
    templates(
        EnvironmentSetup,
        ArtifactoryDockerLogin,
    )

    name = "Deploy terraform"

    steps {
        publishJiraProjectId(scriptPath)
        script {
            name = "Publish Teamcity Agent IP"
            scriptContent = """
                #! /bin/sh
                
                AGENT_IP=$(curl ifconfig.me)
                echo "##teamcity[setParameter name='env.TF_VAR_teamcity_agent_ip' value='${'$'}AGENT_IP']"
            """.trimIndent()
        }
        publishTerraformVariables(scriptPath)
        terraformConfig(scriptPath, dockerImage, deploymentWorkingDirectory)
        terraformDeploy(scriptPath, dockerImage, deploymentWorkingDirectory)
        publishAzureResourceData(scriptPath, dockerImage)
    }

    agent.add_to_requirements(this)

    params {
        param("terraform.state.key", "$projectName/%teamcity.build.branch%")
    }
})
