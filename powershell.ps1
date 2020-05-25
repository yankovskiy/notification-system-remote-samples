$baseUrl = "http://ns.local:8080/"

$jobsUrl = $baseUrl + "jobs"
$completeUrl = $baseUrl + "complete"

$hostname = hostname

$data = Invoke-WebRequest -Uri $jobsUrl

$json = ConvertFrom-Json -InputObject $data.Content

if ($json.ok) {
    ForEach ($job in $json.jobs) {
        # если хост из задачи это наш хост
        if ($job.data.host -eq $hostname) {
            $target = $job.data.target
            $command = $job.data.command
            $id = $job._id

            # Выполняем команду
            if ($target -eq "logs" -and $command -eq "remove") {
                # выполнение задачи (очистка логов)
                Remove-Item /tmp/problem.txt

                # уведомление бота о выполненной задаче
                $body = @{ "_id" = $id }
                $data = Invoke-WebRequest -Uri $completeUrl -Method POST -Body ($body|ConvertTo-Json) -ContentType "application/json"
                
                $postJson = ConvertFrom-Json -InputObject $data.Content
                if ($postJson.ok) {
                    "Задача $id выполнена"
                }
            }
        }
    }
}
else {
    "Error: " + $json.message
}
