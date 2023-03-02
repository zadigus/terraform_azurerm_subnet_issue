package settings

import jetbrains.buildServer.configs.kotlin.v2019_2.BuildType
import shared.azure.build_steps.publishAzureResourceData
import shared.common.Agent
import shared.common.Architecture
import shared.common.DockerImage
import shared.common.build_steps.publishJiraProjectId
import shared.infrastructure.build_steps.*
import shared.templates.ArtifactoryDockerLogin
import shared.templates.EnvironmentSetup

class TerraformDestroyBuild(
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

    name = "Destroy terraform"

    steps {
        publishJiraProjectId(scriptPath)
        publishTerraformVariables(scriptPath)
        publishAzureResourceData(scriptPath, dockerImage)
        terraformConfig(scriptPath, dockerImage, deploymentWorkingDirectory)
        pullTerraformState(scriptPath, dockerImage, deploymentWorkingDirectory)
        destroyNodeResourceGroup(scriptPath, dockerImage)
        terraformDestroy(scriptPath, dockerImage, deploymentWorkingDirectory)
        deleteTerraformStateFile(scriptPath, dockerImage, deploymentWorkingDirectory)
    }

    agent.add_to_requirements(this)

    params {
        param("terraform.state.key", "$projectName/%teamcity.build.branch%")
    }
})