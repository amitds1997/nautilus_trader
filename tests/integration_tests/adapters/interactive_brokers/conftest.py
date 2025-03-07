# -------------------------------------------------------------------------------------------------
#  Copyright (C) 2015-2024 Nautech Systems Pty Ltd. All rights reserved.
#  https://nautechsystems.io
#
#  Licensed under the GNU Lesser General Public License Version 3.0 (the "License");
#  You may not use this file except in compliance with the License.
#  You may obtain a copy of the License at https://www.gnu.org/licenses/lgpl-3.0.en.html
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# -------------------------------------------------------------------------------------------------

import pytest

# fmt: off
from nautilus_trader.adapters.interactive_brokers.client import InteractiveBrokersClient
from nautilus_trader.adapters.interactive_brokers.common import IB_VENUE
from nautilus_trader.adapters.interactive_brokers.config import InteractiveBrokersDataClientConfig
from nautilus_trader.adapters.interactive_brokers.config import InteractiveBrokersExecClientConfig
from nautilus_trader.adapters.interactive_brokers.config import InteractiveBrokersGatewayConfig
from nautilus_trader.adapters.interactive_brokers.config import InteractiveBrokersInstrumentProviderConfig
from nautilus_trader.adapters.interactive_brokers.factories import InteractiveBrokersLiveDataClientFactory
from nautilus_trader.adapters.interactive_brokers.factories import InteractiveBrokersLiveExecClientFactory
from nautilus_trader.adapters.interactive_brokers.providers import InteractiveBrokersInstrumentProvider
from nautilus_trader.model.events import AccountState
from nautilus_trader.model.identifiers import AccountId
from nautilus_trader.model.identifiers import Venue
from nautilus_trader.test_kit.stubs.events import TestEventStubs
from tests.integration_tests.adapters.interactive_brokers.test_kit import IBTestContractStubs


# fmt: on


@pytest.fixture()
def venue():
    return IB_VENUE


@pytest.fixture()
def instrument():
    return IBTestContractStubs.aapl_instrument()


@pytest.fixture()
def gateway_config():
    return InteractiveBrokersGatewayConfig(
        username="test",
        password="test",
    )


@pytest.fixture()
def data_client_config():
    return InteractiveBrokersDataClientConfig(
        ibg_host="127.0.0.1",
        ibg_port=0,
        ibg_client_id=1,
    )


@pytest.fixture()
def exec_client_config():
    return InteractiveBrokersExecClientConfig(
        ibg_host="127.0.0.1",
        ibg_port=0,
        ibg_client_id=1,
        account_id="DU123456",
    )


@pytest.fixture()
def ib_client(data_client_config, loop, msgbus, cache, clock):
    client = InteractiveBrokersClient(
        loop=loop,
        msgbus=msgbus,
        cache=cache,
        clock=clock,
        host=data_client_config.ibg_host,
        port=data_client_config.ibg_port,
        client_id=data_client_config.ibg_client_id,
    )
    yield client
    client._stop()


@pytest.fixture()
def instrument_provider(ib_client):
    return InteractiveBrokersInstrumentProvider(
        client=ib_client,
        config=InteractiveBrokersInstrumentProviderConfig(),
    )


@pytest.fixture()
def data_client(mocker, data_client_config, venue, loop, msgbus, cache, clock):
    mocker.patch(
        "nautilus_trader.adapters.interactive_brokers.factories.get_cached_ib_client",
        return_value=InteractiveBrokersClient(
            loop=loop,
            msgbus=msgbus,
            cache=cache,
            clock=clock,
            host=data_client_config.ibg_host,
            port=data_client_config.ibg_port,
            client_id=data_client_config.ibg_client_id,
        ),
    )
    client = InteractiveBrokersLiveDataClientFactory.create(
        loop=loop,
        name=venue.value,
        config=data_client_config,
        msgbus=msgbus,
        cache=cache,
        clock=clock,
    )
    client._client.start()
    return client


@pytest.fixture()
def exec_client(mocker, exec_client_config, venue, loop, msgbus, cache, clock):
    mocker.patch(
        "nautilus_trader.adapters.interactive_brokers.factories.get_cached_ib_client",
        return_value=InteractiveBrokersClient(
            loop=loop,
            msgbus=msgbus,
            cache=cache,
            clock=clock,
            host=exec_client_config.ibg_host,
            port=exec_client_config.ibg_port,
            client_id=exec_client_config.ibg_client_id,
        ),
    )
    client = InteractiveBrokersLiveExecClientFactory.create(
        loop=loop,
        name=venue.value,
        config=exec_client_config,
        msgbus=msgbus,
        cache=cache,
        clock=clock,
    )
    client._client.start()
    client._client.process_managed_accounts(accounts_list="DU123456,")
    client._client.process_next_valid_id(order_id=1)
    return client


@pytest.fixture()
def account_state(venue: Venue) -> AccountState:
    return TestEventStubs.cash_account_state(account_id=AccountId(f"{venue.value}-001"))
