/* eslint-disable import/no-extraneous-dependencies */
/* eslint-disable perfectionist/sort-imports */
/* eslint-disable perfectionist/sort-named-imports */
/* eslint-disable import/order */
/* eslint-disable */

import { Box, Container, Stack, Typography, Unstable_Grid2 as Grid } from '@mui/material';
import {
    Button,
    Card,
    CardActions,
    CardContent,
    CardHeader,
    Divider,
    TextField
} from '@mui/material';
import { AccountProfile } from './account/account-profile';
import { AccountProfileDetails } from './account/account-profile-details';
import ChangePassword from './account/change-password';


export default function MyProfile() {
    return (
        <Box
            sx={{
                // flexGrow: 1,
                // py: 8
            }}
        >
            <Container maxWidth="lg">
                <Stack spacing={3}>
                    <div>
                        <Typography variant="h4">
                            Thông tin cá nhân
                        </Typography>
                    </div>
                    <div>
                        <Grid
                            container
                            spacing={3}
                        >
                            <Grid
                                xs={12}
                                md={6}
                                lg={4}
                            >
                                <AccountProfile />
                            </Grid>
                            <Grid
                                xs={12}
                                md={6}
                                lg={8}
                            >
                                <AccountProfileDetails />
                            </Grid>
                        </Grid>
                        <ChangePassword />
                    </div>
                </Stack>
            </Container>
        </Box>
    );
}