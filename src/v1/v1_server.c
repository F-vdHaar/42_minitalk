/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   v1_server.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: fvon-der <fvon-der@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/10/10 14:51:18 by fvon-der          #+#    #+#             */
/*   Updated: 2024/11/04 19:33:47 by fvon-der         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "v1_minitalk.h"

static void	setup_signal_handling(void);
static void	handle_signal(int sig, siginfo_t *info, void *context);

// Signal handler for SIGUSR1 and SIGUSR2 signals
// Shift current_char left to make room for the next bit
// Set least significant bit to 1 if SIGUSR2
// If 8 bits (1 character) have been received, print the character
// (void)  -> this is for some backwards compatibility stuff
static void	handle_signal(int sig, siginfo_t *info, void *context)
{
	static int		bit_count = 0;
	static char		current_char = 0;

	(void)info;
	(void)context;
	current_char <<= 1;
	if (sig == SIGUSR2)
		current_char |= 1;
	bit_count++;
	if (bit_count == 8)
	{
		write(1, &current_char, 1);
		bit_count = 0;
		current_char = 0;
	}
}

// Set up signal handling for SIGUSR1 and SIGUSR2
static void	setup_signal_handling(void)
{
	struct sigaction	sa;

	sa.sa_flags = SA_SIGINFO;
	sa.sa_sigaction = handle_signal;
	sigemptyset(&sa.sa_mask);
	sigaction(SIGUSR1, &sa, NULL);
	sigaction(SIGUSR2, &sa, NULL);
}

	// Print the server's PID
	// Setup signal handlers
	// Server runs indefinitely, waiting for signals
int	main(void)
{
	ft_printf("Server PID: %d\n", getpid());
	setup_signal_handling();
	while (1)
		pause();
	return (0);
}
