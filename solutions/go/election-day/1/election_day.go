package electionday

import "fmt"

func NewVoteCounter(initialVotes int) *int {
	counter := initialVotes

	return &counter
}

func VoteCount(counter *int) int {
	if counter == nil {
		return 0
	}

	return *counter
}

func IncrementVoteCount(counter *int, increment int) {
	*counter += increment
}

func NewElectionResult(candidateName string, votes int) *ElectionResult {
	return &ElectionResult{Name: candidateName, Votes: votes}
}

func DisplayResult(result *ElectionResult) string {
	return fmt.Sprintf("%s (%d)", result.Name, result.Votes)
}

func DecrementVotesOfCandidate(results map[string]int, candidate string) {
	results[candidate]--
}
