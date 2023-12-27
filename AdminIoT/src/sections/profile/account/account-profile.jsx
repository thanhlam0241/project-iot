/* eslint-disable import/no-extraneous-dependencies */
/* eslint-disable perfectionist/sort-imports */
/* eslint-disable perfectionist/sort-named-imports */

import {
    Avatar,
    Box,
    // Button,
    Card,
    // CardActions,
    CardContent,
    Divider,
    Typography
} from '@mui/material';

import useAuth from 'src/hooks/Auth/auth';

export function AccountProfile() {

    const { auth } = useAuth();

    return (
        <Card sx={{
            height: '100%'
        }}>
            <CardContent>
                <Box
                    sx={{
                        alignItems: 'center',
                        display: 'flex',
                        flexDirection: 'column'
                    }}
                >
                    <Avatar
                        src={auth.avatar}
                        sx={{
                            height: 80,
                            mb: 2,
                            width: 80
                        }}
                    />
                    <Typography
                        gutterBottom
                        variant="h4"
                    >
                        {auth.fullname}
                    </Typography>
                    <Typography
                        color="text.secondary"
                        variant="h6"
                    >
                        {auth.role}
                    </Typography>
                    <Typography
                        color="text.secondary"
                        variant="body2"
                    >
                        {auth.address}
                    </Typography>
                </Box>
            </CardContent>
            <Divider />
            {/* <CardActions>
                <Button
                    fullWidth
                    variant="text"
                >
                    Upload picture
                </Button>
            </CardActions> */}
        </Card>
    );
}