/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   v1_utils.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: fvon-der <fvon-der@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/04 19:29:25 by fvon-der          #+#    #+#             */
/*   Updated: 2024/11/04 19:33:50 by fvon-der         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "v1_minitalk.h"

void	send_bit(pid_t pid, int signal)
{
	if (signal != SIGUSR1 && signal != SIGUSR2)
	{
		ft_printf("Invalid signal: %d\n", signal);
		return ;
	}
	if (kill(pid, signal) == -1)
		print_exit("ERROR: Could not send signal", 0);
}

void	print_exit(const char *message, int mode)
{
	if (mode == 1)
	{
		ft_printf("%s\n", message);
		exit(EXIT_SUCCESS);
	}
	else
	{
		ft_printf("%s\n", message);
		exit(EXIT_FAILURE);
	}
}
